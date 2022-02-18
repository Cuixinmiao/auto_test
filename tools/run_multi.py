#!/usr/bin/env python
"""
Test psycopg with CockroachDB.
"""

import time
import random
import logging
from argparse import ArgumentParser, RawTextHelpFormatter

import psycopg2
from psycopg2.errors import SerializationFailure
import hashlib
import faker
from  multiprocessing import Process
from threading import Thread
from queue import Queue
from time import sleep
fd = faker.Faker("zh_CN")


def gen_data_queue(numamount):
    q = Queue(numamount)
    for i in range(1,numamount+1):
        if i%2 != 0:
            q.put(i)
    return q

def drop_accounts(conn):
    conn.autocommit = False
    with conn.cursor() as cur:
        cur.execute("DROP TABLE IF EXISTS accounts")
        cur.execute("DROP TABLE IF EXISTS accounts_insert")
        conn.commit()


def import_accounts(conn):
    pass
    


def create_accounts(conn):
    conn.autocommit = False
    with conn.cursor() as cur:
        cur.execute("""CREATE TABLE IF NOT EXISTS accounts (
                id INT PRIMARY KEY, 
                balance INT, 
                hashstr varchar(500),
                province varchar(100),
                address varchar(100),
                ssn varchar(20),
                company varchar(200),
                date_time timestamp,
                dar string ARRAY,
                text_type text)"""
            )

        cur.execute("""CREATE TABLE IF NOT EXISTS accounts_insert (
                id INT PRIMARY KEY, 
                balance INT, 
                hashstr varchar(500),
                province varchar(100),
                address varchar(100),
                ssn varchar(20),
                company varchar(200),
                date_time timestamp,
                dar string ARRAY,
                text_type text)"""
            )
        logging.debug("create_accounts(): status message: %s", cur.statusmessage)
        conn.commit()

def insert_accounts(conn,numamount):
    conn.autocommit=False
    count=1
    for i in range(1,numamount+1):
        if i%2 != 0:
            fromId = i
            toId = i+1
        with conn.cursor() as cur:
            cur.execute("""UPSERT INTO accounts (id, balance,hashstr,province,address,ssn,company,date_time,dar,text_type) VALUES 
            (%s,1000,%s,%s,%s,%s,%s,%s,ARRAY[%s,%s,%s],%s), 
            (%s, 250,%s,%s,%s,%s,%s,%s,ARRAY[%s,%s,%s],%s)
            """\
            ,(fromId,\
            hashlib.sha512(str(fromId).encode("utf-8")).hexdigest().upper(),\
            fd.province(),\
            fd.address(),\
            fd.ssn(),\
            fd.company(),\
            fd.date_time(),\
            fd.random_letter(),fd.random_letter(),\
            fd.random_letter(),fd.text(),\
            toId, \
            hashlib.sha512(str(toId).encode("utf-8")).hexdigest().upper(),\
            fd.province(),\
            fd.address(),\
            fd.ssn(),\
            fd.company(),\
            fd.date_time(),\
            fd.random_letter(),fd.random_letter(),fd.random_letter(),\
            fd.text(),)\
            )
            if count%500 == 0:
                print(count)
                conn.commit()
            count = count + 1
    conn.commit()
    logging.debug("insert_accounts(): status message: %s", cur.statusmessage)


def delete_accounts(conn):
    with conn.cursor() as cur:
        cur.execute("DELETE FROM bank.accounts")
        logging.debug("delete_accounts(): status message: %s", cur.statusmessage)
    conn.commit()


def print_balances(conn,fromId,toId):
    with conn.cursor() as cur:
        cur.execute("SELECT id, balance FROM accounts where id = %s or id = %s",(fromId,toId))
        logging.debug("print_balances(): status message: %s", cur.statusmessage)
        rows = cur.fetchall()
        conn.commit()
        print(f"Balances at {time.asctime()}:")
        for row in rows:
            print(row)


def transfer_funds(conn, frm, to, amount):
    with conn.cursor() as cur:

        # Check the current balance.
        cur.execute("SELECT balance FROM accounts WHERE id = %s", (frm,))
        from_balance = cur.fetchone()[0]
        if from_balance < amount:
            raise RuntimeError(
                f"Insufficient funds in {frm}: have {from_balance}, need {amount}"
            )

        # Perform the transfer.
        cur.execute(
            "UPDATE accounts SET balance = balance - %s WHERE id = %s", (amount, frm)
        )
        cur.execute(
            "UPDATE accounts SET balance = balance + %s WHERE id = %s", (amount, to)
        )
        cur.execute(
                "insert into accounts_insert select * from accounts where id = %s",(frm,)
        )
        cur.execute(
                "insert into accounts_insert select * from accounts where id = %s",(to,)
        )

    conn.commit()
    logging.debug("transfer_funds(): status message: %s", cur.statusmessage)


def run_transaction(conn, op, max_retries=3):
    """
    Execute the operation *op(conn)* retrying serialization failure.

    If the database returns an error asking to retry the transaction, retry it
    *max_retries* times before giving up (and propagate it).
    """
    # leaving this block the transaction will commit or rollback
    # (if leaving with an exception)
    with conn:
        for retry in range(1, max_retries + 1):
            try:
                op(conn)

                # If we reach this point, we were able to commit, so we break
                # from the retry loop.
                return

            except SerializationFailure as e:
                # This is a retry error, so we roll back the current
                # transaction and sleep for a bit before retrying. The
                # sleep time increases for each failed transaction.
                logging.debug("got error: %s", e)
                conn.rollback()
                logging.debug("EXECUTE SERIALIZATION_FAILURE BRANCH")
                sleep_ms = (2 ** retry) * 0.1 * (random.random() + 0.5)
                logging.debug("Sleeping %s seconds", sleep_ms)
                time.sleep(sleep_ms)

            except psycopg2.Error as e:
                logging.debug("got error: %s", e)
                logging.debug("EXECUTE NON-SERIALIZATION_FAILURE BRANCH")
                raise e

        raise ValueError(f"Transaction did not succeed after {max_retries} retries")


def test_retry_loop(conn):
    """
    Cause a seralization error in the connection.

    This function can be used to test retry logic.
    """
    with conn.cursor() as cur:
        # The first statement in a transaction can be retried transparently on
        # the server, so we need to add a dummy statement so that our
        # force_retry() statement isn't the first one.
        cur.execute("SELECT now()")
        cur.execute("SELECT crdb_internal.force_retry('1s'::INTERVAL)")
    logging.debug("test_retry_loop(): status message: %s", cur.statusmessage)

def update_select(q,amount):
    opt = parse_cmdline()
    logging.basicConfig(level=logging.DEBUG if opt.verbose else logging.INFO)
    conn = psycopg2.connect(opt.dsn)
    conn.autocommit =False
    while True:
        if q.empty():
            conn.close()
            break
        else:
            fromId = int(q.get())
            toId = fromId + 1
            #print_balances(conn,fromId,toId)
            try:
                run_transaction(conn, lambda conn: transfer_funds(conn, fromId, toId, amount))
                # The function below is used to test the transaction retry logic.  It
                # can be deleted from production code.
                # run_transaction(conn, test_retry_loop)
            except ValueError as ve:
                # Below, we print the error and continue on so this example is easy to
                # run (and run, and run...).  In real code you should handle this error
                # and any others thrown by the database interaction.
                logging.debug("run_transaction(conn, op) failed: %s", ve)
            print_balances(conn,fromId,toId)
            time.sleep(0.1)

def main():
    opt = parse_cmdline()
    logging.basicConfig(level=logging.DEBUG if opt.verbose else logging.INFO)
    conn1 = psycopg2.connect(opt.dsn)
    drop_accounts(conn1)
    create_accounts(conn1)
    insert_accounts(conn1,numamount)
    conn = psycopg2.connect(opt.dsn)
    q = gen_data_queue(numamount) 
    amount = 100
    lstp = []
    for i in range(1,threadid+1):
        lstp.append(Thread(target=update_select,args=(q,amount)))
    for j in lstp:
        j.start()
    for j in lstp:
        j.join()


def parse_cmdline():
    parser = ArgumentParser(description=__doc__,
                            formatter_class=RawTextHelpFormatter)
    parser.add_argument(
        "dsn",
        help="""\
database connection string

For cockroach demo, use
'postgresql://<username>:<password>@<hostname>:<port>/bank?sslmode=require',
with the username and password created in the demo cluster, and the hostname
and port listed in the (sql/tcp) connection parameters of the demo cluster
welcome message.

For CockroachCloud Free, use
'postgres://<username>:<password>@free-tier.gcp-us-central1.cockroachlabs.cloud:26257/<cluster-name>.bank?sslmode=verify-full&sslrootcert=<your_certs_directory>/cc-ca.crt'.
For qianbase Free, use
'qianbase://<username>:<password>@hostname:26257/bank?sslmode=disable'.

If you are using the connection string copied from the Console, your username,
password, and cluster name will be pre-populated. Replace
<your_certs_directory> with the path to the 'cc-ca.crt' downloaded from the
Console.

"""
    )

    parser.add_argument("-v", "--verbose",
                        action="store_true", help="print debug info")

    opt = parser.parse_args()
    return opt


if __name__ == "__main__":
    numamount = 1000000
    threadid = 20
    main()

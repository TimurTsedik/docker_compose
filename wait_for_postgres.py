import time
import psycopg2
from psycopg2 import OperationalError

def wait_for_postgres():
    while True:
        try:
            conn = psycopg2.connect(
                dbname="mydatabase",
                user="myuser",
                password="mypassword",
                host="postgres",
                port="5432"
            )
            conn.close()
            print("PostgreSQL is ready")
            break
        except OperationalError:
            print("PostgreSQL is not ready yet, waiting...")
            time.sleep(1)

if __name__ == "__main__":
    wait_for_postgres()

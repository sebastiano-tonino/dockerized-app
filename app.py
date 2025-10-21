from flask import Flask, jsonify
import psutil
import platform
import mysql.connector
from config import DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT

app = Flask(__name__)


@app.route("/app/system-data", methods=["GET"])
def get_system_data():
    try:
        cpu_percent = psutil.cpu_percent(interval=0.1)
        memory = psutil.virtual_memory().percent
        system = platform.system()
        return jsonify({
            "cpu_usage": cpu_percent,
            "memory": memory,
            "os": system
        }), 200
    except Exception as e:
        return jsonify({"Error"}), 500

@app.route("/app/database-data", methods=["GET"])
def get_database_data():
    try:
        conn = mysql.connector.connect( 
            host=DB_HOST,
            port=3306,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME,
            charset='utf8mb4',
            collation='utf8mb4_unicode_ci'
        )
        cursor = conn.cursor()
        cursor.execute("SELECT VERSION();")
        version = cursor.fetchone()[0]
        cursor.close()
        conn.close()
        return jsonify({"db_version": version}), 200
    except mysql.connector.Error as e:
        return jsonify({"Error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

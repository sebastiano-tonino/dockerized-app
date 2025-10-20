from flask import Flask, jsonify
import psutil
import platform
import mysql.connector

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
        conn = mysql.connector.connect()
        cursor = conn.cursor()
        cursor.execute("SELECT VERSION();")
        version = cursor.fetchone()[0]
        cursor.close()
        conn.close()
        return jsonify({"db_version": version}), 200
    except mysql.connector.Error as e:
        return jsonify("Error"), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

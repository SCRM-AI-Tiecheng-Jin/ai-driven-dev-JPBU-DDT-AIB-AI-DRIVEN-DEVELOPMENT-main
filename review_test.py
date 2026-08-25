"""ユーザー管理モジュール - Copilot Code Review テスト用。

このファイルには意図的に問題を含めています:
- ハードコードされたシークレット
- SQLインジェクション脆弱性
- ループ内のDB呼び出し
- エラーハンドリング不足
- 不明確な命名
"""

import sqlite3

# 問題1: ハードコードされたAPIキーとパスワード
API_KEY = "sk-1234567890abcdef"
DB_PASSWORD = "admin123"


def get_user(name):
    # 問題2: SQLインジェクション脆弱性（文字列連結でクエリ組み立て）
    conn = sqlite3.connect("users.db")
    cursor = conn.cursor()
    query = "SELECT * FROM users WHERE name = '" + name + "'"
    cursor.execute(query)
    return cursor.fetchall()


def get_all_user_orders(user_ids):
    # 問題3: ループ内での不要なDB呼び出し（N+1問題）
    results = []
    for uid in user_ids:
        conn = sqlite3.connect("users.db")
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM orders WHERE user_id = ?", (uid,))
        results.append(cursor.fetchall())
        conn.close()
    return results


def list_users():
    # 問題4: ページネーションなしで全件取得
    conn = sqlite3.connect("users.db")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users")
    return cursor.fetchall()


def d(x, y):
    # 問題5: 不明確な命名、エラーハンドリングなし（ゼロ除算）
    return x / y


def process(data):
    # 問題6: 入力バリデーションなし、例外を握りつぶす
    try:
        result = eval(data)  # 問題7: eval の使用は危険
        return result
    except Exception:
        pass

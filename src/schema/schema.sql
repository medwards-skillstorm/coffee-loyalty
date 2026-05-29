CREATE TABLE IF NOT EXISTS customers (
    id                      INTEGER PRIMARY KEY,
    name                    TEXT NOT NULL,
    email                   TEXT NOT NULL UNIQUE,
    phone                   TEXT,
    signup                  DATETIME NOT NULL,
    point_balance           INT NOT NULL CHECK(point_balance >= 0),
    tier                    TEXT NOT NULL,
    lifetime_spend          NUMERIC(12,2) NOT NULL CHECK(lifetime_spend >= 0),
    last_order_at           DATETIME
);

CREATE INDEX IF NOT EXISTS ix_customers_name ON customers(name);
CREATE INDEX IF NOT EXISTS ix_customers_email ON customers(email);

CREATE TABLE IF NOT EXISTS orders (
    id                      INTEGER PRIMARY KEY,
    customer_id             INTEGER NOT NULL,
    total                   NUMERIC(12,2) NOT NULL CHECK(total>= 0),
    created_at              DATETIME NOT NULL,
    points_awarded          INTEGER NOT NULL CHECK(points_awarded >= 0),
    FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS ix_orders_customer_id ON orders(customer_id);

CREATE TABLE IF NOT EXISTS drinks (
    id                      INTEGER PRIMARY KEY,
    name                    TEXT NOT NULL,
    base_price              NUMERIC(8,2) NOT NULL CHECK(base_price >= 0)
);
CREATE INDEX IF NOT EXISTS ix_drinks_name ON drinks(name);

CREATE TABLE IF NOT EXISTS order_items(
    id                      INTEGER PRIMARY KEY,
    order_id                INTEGER NOT NULL,
    drink_id                INTEGER NOT NULL,
    size                    TEXT NOT NULL,
    quantity                INTEGER NOT NULL CHECK(quantity > 0),
    FOREIGN KEY(order_id)   REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY(drink_id)   REFERENCES drinks(id)
);

CREATE INDEX IF NOT EXISTS ix_order_items_order_id ON order_items(order_id);
CREATE INDEX IF NOT EXISTS ix_order_items_drink_id ON order_items(drink_id);
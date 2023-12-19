# restaurant-orders-analysis

# Restaurant Orders Database - Table Details

## `order_details` Table

| Column           | Description                         |
|------------------|-------------------------------------|
| order_details_id | Unique identifier for order details |
| order_id         | Unique identifier for the order     |
| order_date       | Date of the order                   |
| order_time       | Time of the order                   |
| item_id          | Unique identifier for the item      |

**Primary Key:** order_details_id

## `menu_items` Table

| Column          | Description                           |
|-----------------|---------------------------------------|
| menu_item_id    | Unique identifier for menu items       |
| item_name       | Name of the menu item                  |
| category        | Category to which the item belongs     |
| price           | Price of the menu item                 |

**Primary Key:** menu_item_id

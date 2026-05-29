from enum import Enum

class DrinkSize(str, Enum):
    SMALL = "small"
    MEDIUM = "medium"
    LARGE = "large"
    
class CustomerTier(str, Enum):
    BRONZE = "bronze"
    SILVER = "silver"
    GOLD = "gold"
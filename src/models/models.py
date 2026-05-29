import datetime
from decimal import Decimal
from typing import Literal

from pydantic import BaseModel, EmailStr, Field
from pydantic_extra_types.phone_numbers import PhoneNumber

from models.enums import CustomerTier, DrinkSize

class Drink(BaseModel): 
    id: int #The DB will be in charge of generating and incrementing unique IDs
    name: str
    base_price: Decimal

class Customer(BaseModel):
    """A single Customer object"""
    id: int #The DB will be in charge of generating and incrementing unique IDs
    name: str = Field(min_length=1, max_length=200)
    email: EmailStr
    phone: PhoneNumber | None = None
    signup: datetime
    point_balance: int
    tier: CustomerTier
    lifetime_spend: int
    last_order_dt: datetime
    
class Order(BaseModel):
    id: int #The DB will be in charge of generating and incrementing unique IDs
    order_items: list[OrderItem] = Field(default_factory=list, max_length=50)
    total: Decimal
    created_at: datetime
    points_awarded: int = Field(gt=0)

class OrderItem(BaseModel):
    drink: Drink
    size: DrinkSize
    quantity: int = Field(gt=0)
    order_id: int
    drink_id: int
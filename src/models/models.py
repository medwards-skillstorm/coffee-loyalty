import datetime
from decimal import Decimal
from typing import Literal

from pydantic import BaseModel, EmailStr, Field
from pydantic_extra_types.phone_numbers import PhoneNumber

Tier = Literal["bronze", "silver", "gold"]

class Customer(BaseModel):
    """A single Customer object"""
    id: int #The DB will be in charge of generating and incrementing unique IDs
    name: str = Field(min_length=1, max_length=200)
    email: EmailStr
    phone: PhoneNumber | None = None
    signup: datetime
    point_balance: int
    tier: Tier
    lifetime_spend: int
    last_order_dt: datetime
    
class Order(BaseModel):
    id: int #The DB will be in charge of generating and incrementing unique IDs
    purchase: list[str] 
    total: Decimal
    created_at: datetime
    
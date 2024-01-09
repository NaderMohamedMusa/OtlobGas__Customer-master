enum OrderStatus {
  none,

  create,

  noDriverFound,

  /// cancel_by_driver
  canceled,

  /// send_to_driver
  sendToDriver,

  /// accept_driver
  acceptDriver,

  /// delivered
  delivered,

  /// rejected
  rejected,

  /// cancel_by_customer
  cancelByCustomer,

  /// cancel_by_customer_because_of
  cancelByCustomerBecauseOf,
}

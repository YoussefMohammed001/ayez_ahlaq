enum SaleStatus {
  done,
  cancelled;

  static SaleStatus fromApi(String? value) =>
      value == 'CANCELLED' ? SaleStatus.cancelled : SaleStatus.done;
}

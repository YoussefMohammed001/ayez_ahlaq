enum StoreFeedSort { relevant, priceAsc, priceDesc, newest }

extension StoreFeedSortApi on StoreFeedSort {
  String toApi() {
    switch (this) {
      case StoreFeedSort.relevant:
        return 'relevant';
      case StoreFeedSort.priceAsc:
        return 'priceAsc';
      case StoreFeedSort.priceDesc:
        return 'priceDesc';
      case StoreFeedSort.newest:
        return 'newest';
    }
  }
}

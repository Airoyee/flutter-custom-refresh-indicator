part of custom_refresh_indicator;

typedef ChildTransformBuilder = Widget Function(
  BuildContext context,
  Widget child,
  IndicatorController controller,
);

/// Describes state of CustomRefreshIndicator
enum IndicatorState {
  /// #### [CustomRefreshIndicator] is idle (There is no action)
  ///
  /// (`CustomRefreshIndicatorData.value == 0`)
  idle,

  /// #### Whether user is draging [CustomRefreshIndicator]
  /// ending the scroll **WILL NOT** result in `onRefresh` call
  ///
  /// (`CustomRefreshIndicatorData.value < 1`)
  draging,

  /// #### [CustomRefreshIndicator] is armed
  /// ending the scroll **WILL** result in:
  /// - `CustomRefreshIndicator.onRefresh` call
  /// - change of status to `loading`
  /// - decreasing `CustomRefreshIndicatorData.value` to `1` in
  /// duration specified by `CustomRefreshIndicator.armedToLoadingDuration`)
  ///
  /// (`CustomRefreshIndicatorData.value >= 1`)
  armed,

  /// #### [CustomRefreshIndicator] is hiding indicator
  /// when `onRefresh` future is resolved or indicator was canceled
  /// (scroll ended when [IndicatorState] was equal to `dragging`
  /// so `value` was less than `1` or the user started scrolling through the list)
  ///
  /// (`CustomRefreshIndicatorData.value` decreases to `0`
  /// in duration specified by `CustomRefreshIndicator.dragingToIdleDuration`)
  hiding,

  /// #### [CustomRefreshIndicator] is awaiting on `onRefresh` call result
  /// When `onRefresh` will resolve [CustomRefreshIndicator] will change state
  /// from `loading` to `hiding` and decrease `CustomRefreshIndicatorData.value`
  /// from `1` to `0` in duration specified by `CustomRefreshIndicator.loadingToIdleDuration`
  ///
  /// (`CustomRefreshIndicatorData.value == 1`)
  loading,
}

class IndicatorController extends ChangeNotifier {
  double _value;

  /// Current indicator value / progress
  double get value => _value;

  IndicatorController({
    @required double value,
    AxisDirection direction,
    ScrollDirection scrollingDirection,
    IndicatorState state,
  })  : _state = state ?? IndicatorState.idle,
        _scrollingDirection = scrollingDirection ?? ScrollDirection.idle,
        _direction = direction ?? AxisDirection.down,
        _value = value;

  @protected
  @visibleForTesting
  void updateAndNotify({
    @required double value,
  }) {
    _value = value;

    notifyListeners();
  }

  ScrollDirection _scrollingDirection;
  void _setScrollingDirection(ScrollDirection userScrollDirection) {
    _scrollingDirection = userScrollDirection;
    notifyListeners();
  }

  /// Direction in which user is scrolling
  ScrollDirection get scrollingDirection => _scrollingDirection;

  /// Scrolling is happening in the positive scroll offset direction.
  bool get isScrollingForward => scrollingDirection == ScrollDirection.forward;

  /// Scrolling is happening in the negative scroll offset direction.
  bool get isScrollingReverse => scrollingDirection == ScrollDirection.reverse;

  /// No scrolling is underway.
  bool get isScrollIdle => scrollingDirection == ScrollDirection.idle;

  AxisDirection _direction;

  /// Sets the direction in which list scrolls
  void _setAxisDirection(AxisDirection direction) {
    _direction = direction;
    notifyListeners();
  }

  /// The direction in which list scrolls
  ///
  /// For example:
  /// ```
  /// ListView.builder(
  ///   scrollDirection: Axis.horizontal,
  ///   reverse: true,
  ///   // ***
  /// ```
  /// will have the direction of `AxisDirection.left`
  AxisDirection get direction => _direction;

  /// Whether list scrolls horrizontally
  ///
  /// (direction equals `AxisDirection.left` or `AxisDirection.right`)
  bool get isHorizontalDirection =>
      direction == AxisDirection.left || direction == AxisDirection.right;

  /// Whether list scrolls vertically
  ///
  /// (direction equals `AxisDirection.up` or `AxisDirection.down`)
  bool get isVerticalDirection =>
      direction == AxisDirection.up || direction == AxisDirection.down;

  IndicatorState _state;

  /// sets indicator state and notifies listeners
  void _setIndicatorState(IndicatorState state) {
    _state = state;
    notifyListeners();
  }

  /// Describes current [CustomRefreshIndicator] state
  IndicatorState get state => _state;
  bool get isArmed => _state == IndicatorState.armed;
  bool get isDraging => _state == IndicatorState.draging;
  bool get isLoading => _state == IndicatorState.loading;
  bool get isHiding => _state == IndicatorState.hiding;
  bool get isIdle => _state == IndicatorState.idle;
}

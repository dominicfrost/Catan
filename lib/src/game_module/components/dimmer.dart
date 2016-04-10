// Copyright (c) 2015, Jerold Albertson. All rights reserved.

part of catan.game_module;

var Dimmer = react.registerComponent(() => new _Dimmer());
class _Dimmer extends w_flux.FluxComponent<GameActions, GameStore> {

  DimmerType get currentDimmer => state['currentDimmer'];
  bool get visible => state['visible'];

  getInitialState() => stateFromStore();

  stateFromStore() => {
    'currentDimmer': store.currentDimmer,
    'visible': store.dimmerVisible,
  };

  setStateFromStore() => setState(stateFromStore());

  Map<w_flux.Store, Function> getStoreHandlers() => { store: (_) => setStateFromStore() };

  bool shouldComponentUpdate(_, nextState) {
    print('shouldComponentUpdate');
    return nextState['currentDimmer'] != currentDimmer || nextState['visible'] != visible;
  }

  render() {
    var dimmerChild;
    if (currentDimmer == DimmerType.TileOptions
        || currentDimmer == DimmerType.PlotOptions
        || currentDimmer == DimmerType.WaterOptions) {
      dimmerChild = ControlPalette({'actions': actions, 'store': store});
    } else if (currentDimmer == DimmerType.ConfirmNewGame) {
      dimmerChild = ConfirmNewGame({'actions': actions, 'store': store});
    }
    return react.div({
      'className': 'ui page dimmer',
      'style': {
        'display': 'block',
        'opacity': store.dimmerVisible ? 1.0 : 0.0,
        'transition': 'opacity .25s ease-in-out',
        'pointerEvents': store.dimmerVisible ? 'auto' : 'none',
      },
    }, dimmerChild);
  }
}

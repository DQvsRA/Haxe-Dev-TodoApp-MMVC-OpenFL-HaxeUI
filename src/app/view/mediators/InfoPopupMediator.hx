package app.view.mediators;

import app.controller.signals.InfoPopupMediatorMessageSignal;
import app.view.components.popups.InfoPopup;
import mmvc.impl.Mediator;

class InfoPopupMediator extends Mediator<InfoPopup>
{
    @inject public var messageSignal:InfoPopupMediatorMessageSignal;

    override public function onRegister()
    {
        super.onRegister();

        messageSignal.add(HandleMessageSignal);
    }

    private function HandleMessageSignal(type:String, ?data:Dynamic):Void {
        switch(type) {
            case InfoPopupMediatorMessageSignal.SHOW_INFO:
                view.showMessage(cast data);
        }
    }

    /**
	@see mmvc.impl.Mediator
	*/
    override public function onRemove():Void
    {
        super.onRemove();
    }

    public function new() { super(); }
}

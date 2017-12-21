package app.controller.signals;
import msignal.Signal.Signal2;

class ApplicationMediatorMessageSignal extends Signal2<String, Dynamic> {

    private static var PREFIX(default, never):String = "application_mediator_signal__";

    public static var SOME_MESSAGE(default, never):String = PREFIX + "some_message";

    public function new() { super(); }
}

package app.controller.signals;

import msignal.Signal.Signal2;
import msignal.Signal.Signal1;

class TodoListMediatorMessageSignal extends Signal2<String, Dynamic>
{
    private static var PREFIX(default, never):String = "todolist_mediator_signal__";

    public static var SETUP_TODOS(default, never):String = PREFIX + "setdata";
    public static var ADD_TODO(default, never):String = PREFIX + "addtodo";
}

package app.view.mediators;

import app.controller.signals.TodoFormMediatorMessageSignal;
import app.controller.signals.todoform.CreateTodoSignal;
import haxe.ui.core.MouseEvent;
import app.view.components.TodoForm;
import mmvc.impl.Mediator;

class TodoFormMediator extends Mediator<TodoForm>
{
    @inject public var messageSignal:TodoFormMediatorMessageSignal;

    @inject public var createTodoSignal:CreateTodoSignal;

    override public function onRegister()
    {
        super.onRegister();

        trace("-> onRegister: view = " + view);
        trace("-> onRegister: interestsSignal = " + messageSignal);

        messageSignal.add(HandleMessageSignal);

        var todoForm:TodoForm = cast getViewComponent();
        todoForm.addButton.onClick = HandleAddButtonClickEvent;
    }

    private function HandleMessageSignal(type:String, ?data:Dynamic):Void
    {
        switch(type) {
            case TodoFormMediatorMessageSignal.CLEAR_FORM:
            {
                var todoForm:TodoForm = cast getViewComponent();
                todoForm.textField.text = "";
            }
        }
    }

    private function HandleAddButtonClickEvent(e:MouseEvent):Void
    {
        var todoForm:TodoForm = cast getViewComponent();
        createTodoSignal.complete.addOnce(function(success:Bool){
            todoForm.unlock();
        });
        todoForm.lock();
        createTodoSignal.dispatch(todoForm.textField.text);
    }

    public function new() { super(); }
}

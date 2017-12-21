package app.controller.commands;
import app.controller.commands.prepare.PrepareCompleteCommand;
import app.controller.commands.prepare.PrepareControllerCommand;
import app.controller.commands.prepare.PrepareInjectionCommand;
import app.controller.commands.prepare.PrepareViewCommand;
import mmvc.impl.MacroCommand;

class StartupCommand extends MacroCommand
{
    override public function initializeMacroCommand():Void
    {
        addSubCommand( PrepareInjectionCommand );
        addSubCommand( PrepareControllerCommand );
        addSubCommand( PrepareViewCommand );
        addSubCommand( PrepareCompleteCommand );
    }

    public function new() { super(); }
}

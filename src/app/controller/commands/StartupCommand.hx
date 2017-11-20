package app.controller.commands;

import mmvc.impl.MacroCommand;
import app.controller.commands.prepare.PrepareInjectionCommand;
import app.controller.commands.prepare.PrepareCompleteCommand;
import app.controller.commands.prepare.PrepareViewCommand;
import app.controller.commands.prepare.PrepareControllerCommand;

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

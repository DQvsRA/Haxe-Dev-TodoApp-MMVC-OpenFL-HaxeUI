package app.model.vos;

class Todo
{
    public var id:Int;
    public var text:String;
    public var completed:Bool;

    public function new(id:Int, text:String, completed:Bool) {
        this.id = id;
        this.text = text;
        this.completed = completed;
    }
}

package app.model.services;
import haxe.Json;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.URLLoader;
import openfl.net.URLLoaderDataFormat;
import openfl.net.URLRequest;
import openfl.net.URLRequestHeader;
import openfl.net.URLRequestMethod;
import openfl.net.URLVariables;

class ServerService
{
    private static var __instance(default, never):ServerService = new ServerService();
    public static function getInstance():ServerService { return __instance; }

    private function new() {}

    public function performRequest(
        route       : String,
        method      : String,
        callback    : String->Dynamic->Void,
        ?params     : Map<String,Dynamic>
    ):Void {
        var onComplete:Event->Void;
        var request:URLRequest = new URLRequest(route);
        var loader:URLLoader = new URLLoader();

        trace("> route = " + route);
        trace("> method = " + method);
        trace("> callback = " + callback);
        if(params != null) trace("> params = " + params);

        onComplete = function(event:Event):Void
        {
            loader.removeEventListener(Event.COMPLETE, onComplete);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, onComplete);

            if(Type.getClass(event) == IOErrorEvent)
            {
                var errorEvent:IOErrorEvent = cast event;
                callback(errorEvent.text, null);
            }
            else
            {
                callback(null, Json.parse(loader.data));
            }

            loader.close();

            onComplete = null;
            request = null;
            loader = null;
        }

        loader.addEventListener(Event.COMPLETE, onComplete);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onComplete);
        loader.dataFormat = URLLoaderDataFormat.TEXT;

        AddRequestMethod(request, method);
        if(params != null) AddRequestParams(request, params);

        trace("-> performRequest: " + request.url, method, callback);
        loader.load(request);
    }

    private function AddRequestParams(request:URLRequest, params:Map<String, Dynamic>):Void
    {
        var variables:URLVariables = request.data;
        if(variables == null) variables = new URLVariables();

        var paramsToString:String = "";
        var keys:Iterator<String> = params.keys();
        var next:Bool = keys.hasNext();

        while(next)
        {
            var key:String = keys.next();
            var value:String = StringTools.urlEncode(params.get(key));
            paramsToString += '$key=$value';
            next = keys.hasNext();
            if(next) paramsToString += "&";
        }
        trace("add variable: " + paramsToString);

        variables.decode(paramsToString);

        request.data = variables;
    }

    private function AddRequestMethod(request:URLRequest, method:String):Void
    {
        if(method == URLRequestMethod.DELETE) {
            request.method = URLRequestMethod.POST;
            request.requestHeaders.push(new URLRequestHeader("X-HTTP-Method-Override", URLRequestMethod.DELETE));
            request.data = new URLVariables("_method=" + URLRequestMethod.DELETE);
        } else if(method == URLRequestMethod.PUT) {
            request.method = URLRequestMethod.POST;
            request.requestHeaders.push(new URLRequestHeader("X-HTTP-Method-Override", URLRequestMethod.PUT));
        } else {
            request.method = method;
        }

        trace("request.method = " + request.method);
    }
}

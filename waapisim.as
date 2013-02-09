import flash.external.ExternalInterface;
import mx.controls.*;

public var WAAPISimSndch:SoundChannel;
public function Start():void {
	setTimeout(InitializeWAAPISim,400);
	setInterval(Interval,30);
}
public function InitializeWAAPISim():void {
	var snd:Sound = new Sound(); 
	snd.addEventListener(SampleDataEvent.SAMPLE_DATA, GetSamples); 
	WAAPISimSndch=snd.play();
}
private function Interval():void {
	ExternalInterface.call("waapisimFlashOffset",WAAPISimSndch.position);
}
public function GetSamples(event:SampleDataEvent):void {
	var dat:String = ExternalInterface.call("waapisimFlashGetData");
	var l:uint=dat.length;
	for(var i:int=0;i<l;++i) {
		event.data.writeFloat(dat.charCodeAt(i)/32768-1);
	}
}


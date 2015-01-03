var recLength = 0,
  recBuffers = [],
  sampleRate;

this.onmessage = function(e){
  switch(e.data.command){
    case 'init':
      init(e.data.config);
      break;
    case 'record':
      record(e.data.buffer);
      break;
    case 'exportWAV':
      exportWAV(e.data.type);
      break;
    case 'getBuffer':
      getBuffer();
      break;
    case 'clear':
      clear();
      break;
  }
};

function init(config){
  sampleRate = 44100;
}

function record(inputBuffer){
  var bufferL = inputBuffer[0];
  var bufferR = inputBuffer[1];
  var interleaved = interleave(bufferL, bufferR);
  recBuffers.push(interleaved);
  recLength += interleaved.length;
}

function exportWAV(type){
  var buffer = mergeBuffers(recBuffers, recLength);
  var dataview = encodeWAV(buffer);
  var audioBlob = new Blob([dataview], { type: type });

  this.postMessage(audioBlob);
}

function getBuffer() {
  var buffer = mergeBuffers(recBuffers, recLength)
  this.postMessage(buffer);
}

function clear(){
  recLength = 0;
  recBuffers = [];
}

function mergeBuffers(recBuffers, recLength){
  var result = new Float32Array(recLength);
  var offset = 0;
  for (var i = 0; i < recBuffers.length; i++){
    result.set(recBuffers[i], offset);
    offset += recBuffers[i].length;
  }
  return result;
}

function interleave(inputL, inputR){
	var length = inputL.length / 5;
	var result = new Float32Array(length);

	var index = 0,
	  inputIndex = 0;

	while (index < length) {
	    result[index++] =    ((1/5) * (inputL[inputIndex++] + inputL[inputIndex++] +
	                              inputL[inputIndex++] + inputL[inputIndex++]+ inputL[inputIndex++]));
	}

	return result;
	  
}

function floatTo16BitPCM(output, offset, input){
  for (var i = 0; i < input.length; i++, offset+=2){
    var s = Math.max(-1, Math.min(1, input[i]));
    output.setInt16(offset, s < 0 ? s * 0x8000 : s * 0x7FFF, true);
  }
}

function writeString(view, offset, string){
  for (var i = 0; i < string.length; i++){
    view.setUint8(offset + i, string.charCodeAt(i));
  }
}

function encodeWAV(samples){
  
  var buffer = new ArrayBuffer(44 + samples.length * 2);
  var view = new DataView(buffer);

  /* RIFF identifier */
  writeString(view, 0, 'RIFF');
  /* file length */
  view.setUint32(4, 32 + samples.length * 2, true);
  /* RIFF type */
  writeString(view, 8, 'WAVE');
  /* format chunk identifier */
  writeString(view, 12, 'fmt ');
  /* format chunk length */
  view.setUint32(16, 16, true);
  /* sample format (raw) */
  view.setUint16(20, 1, true);
  /* channel count */
  view.setUint16(22, 1, true);
  /* sample rate */
  view.setUint32(24, 44100, true);
  /* byte rate (sample rate * block align) */
  view.setUint32(28, 44100 * 2, true);
  /* block align (channel count * bytes per sample) */
  view.setUint16(32, 2, true);
  /* bits per sample */
  view.setUint16(34, 16, true);
  /* data chunk identifier */
  writeString(view, 36, 'data');
  /* data chunk length */
  view.setUint32(40, samples.length * 4, true);

  floatTo16BitPCM(view, 44, samples);

  var song = nachiketh(view,samples);
  
  return view;
}


function nachiketh(view,samples)
{
	
	console.log("Hello world");
	/* RIFF identifier */
	  writeString(view, 0, 'RIFF');
	  /* file length */
	  view.setUint32(4, 32 + samples.length * 2, true);
	  /* RIFF type */
	  writeString(view, 8, 'WAVE');
	  /* format chunk identifier */
	  writeString(view, 12, 'fmt ');
	  /* format chunk length */
	  view.setUint32(16, 16, true);
	  /* sample format (raw) */
	  view.setUint16(20, 1, true);
	  /* channel count */
	  view.setUint16(22, 1, true);
	  /* sample rate */
	  view.setUint32(24, 8000, true);
	  /* byte rate (sample rate * block align) */
	  view.setUint32(28, 8000 * 2, true);
	  /* block align (channel count * bytes per sample) */
	  view.setUint16(32, 2, true);
	  /* bits per sample */
	  view.setUint16(34,16, true);
	  /* data chunk identifier */
	  writeString(view, 36, 'data');
	  /* data chunk length */
	  view.setUint32(40, samples.length * 2, true);

	  floatTo16BitPCM(view, 44, samples);
	  
	return view;
	
	}

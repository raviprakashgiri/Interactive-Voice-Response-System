var audio_context,
    recorder,
    volume,
    volumeLevel = 0,
    currentEditedSoundIndex;

function startUserMedia(stream) {
  var input = audio_context.createMediaStreamSource(stream);
  console.log('Media stream created.');

  volume = audio_context.createGain();

  
  volume.gain.value = volumeLevel;
  input.connect(volume);
  volume.connect(audio_context.destination);
  console.log('Input connected to audio context destination.');
  
  recorder = new Recorder(input);
  console.log('Recorder initialised.');
}

function changeVolume(value) {
  if (!volume) return;
  volumeLevel = value;
  volume.gain.value = value;
}

function startRecording(button) {
  recorder && recorder.record();
  button.disabled = true;
  button.nextElementSibling.disabled = false;
  console.log('Recording...');
  changeColor();
}

function stopRecording(button) {
  recorder && recorder.stop();
  button.disabled = true;
  button.previousElementSibling.disabled = false;
  console.log('Stopped recording.');
  document.getElementById('output').innerHTML = "Stoped...";
  stoptimer();
  // create WAV download link using audio data blob
  createDownloadLink();
  
 // recorder.clear();
}

function createDownloadLink() {
  currentEditedSoundIndex = -1;
  console.log('tttttttttttttt');
  recorder && recorder.exportWAV(handleWAV.bind(this));
}

function handleWAV(blob) {
	console.log('hhhhhhhhhhhhh');
  var tableRef = document.getElementById('recordingslist');
  if (currentEditedSoundIndex !== -1) {
    $('#recordingslist tr:nth-child(' + (currentEditedSoundIndex + 1) + ')').remove();
  }

  var url = URL.createObjectURL(blob);
  var newRow   = tableRef.insertRow(currentEditedSoundIndex);
  newRow.className = 'soundBite';
  var audioElement = document.createElement('audio');
  var downloadAnchor = document.createElement('a');
  var editButton = document.createElement('button');
  
  audioElement.controls = true;
  audioElement.src = url;

  downloadAnchor.href = url;
  downloadAnchor.download = new Date().toISOString() + '.wav';
  downloadAnchor.innerHTML = 'Download';
  downloadAnchor.className = 'btn btn-primary';

  editButton.onclick = function(e) {
    $('.recorder.container').addClass('hide');
    $('.editor.container').removeClass('invisible');

    currentEditedSoundIndex = $(e.target).closest('tr').index();
    
    var f = new FileReader();
    f.onload = function(e) {
        audio_context.decodeAudioData(e.target.result, function(buffer) {
          console.warn(buffer);
          $('#audioLayerControl')[0].handleAudio(buffer);
        }, function(e) {
          console.warn(e);
        });
    };
    f.readAsArrayBuffer(blob);
  };
  editButton.innerHTML = 'Edit';
  editButton.className = 'btn btn-primary';

  var newCell = newRow.insertCell(-1);
  newCell.appendChild(audioElement);
  newCell = newRow.insertCell(-1);
  newCell.appendChild(downloadAnchor);
  newCell = newRow.insertCell(-1);
  newCell.appendChild(editButton);

  newCell = newRow.insertCell(-1);
  var toggler;
  //for (var i = 0, l = 8; i < l; i++) {
    //toggler = document.createElement('input');
    //$(toggler).attr('type', 'checkbox');
   // newCell.appendChild(toggler);
  //}
}

window.onload = function init() {
  try {
    // webkit shim
    window.AudioContext = window.AudioContext || window.webkitAudioContext || window.mozAudioContext;
    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
    window.URL = window.URL || window.webkitURL || window.mozURL;
    
    audio_context = new AudioContext();
    console.log('Audio context set up.');
    console.log('navigator.getUserMedia ' + (navigator.getUserMedia ? 'available.' : 'not present!'));
  } catch (e) {
    console.warn('No web audio support in this browser!');
  }
  
  navigator.getUserMedia({audio: true}, startUserMedia, function(e) {
    console.warn('No live audio input: ' + e);
  });
};



var count=0,chkfn=null;
function changeColor() {
// Call function with 1000 milliseconds gap
chkfn = setInterval(starttimer, 900);
}
function starttimer() {
count += 1;
var oElem = document.getElementById("output");
oElem.style.color = oElem.style.color == "red" ? "blue" : "red";
document.getElementById("output").innerHTML = "Your Time Starts: " + count;
}
function stoptimer() {
clearInterval(chkfn);
chkfn = null;
count = 0;
document.getElementById("output").innerHTML = 'Stoped';
}



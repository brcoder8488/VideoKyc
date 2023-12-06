<%@ Page Language="C#" AutoEventWireup="true" CodeFile="videoKYC.aspx.cs" Inherits="videoKYC" %>

<!DOCTYPE html>
<html>
<head>
    <title>:: Myway Video Kyc ::</title>
</head>
<body>
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        table
        {
            border: 1px solid #ccc;
            border-collapse: collapse;
        }
        table th
        {
            background-color: #F7F7F7;
            color: #333;
            font-weight: bold;
        }
        table th, table td
        {
            padding: 5px;
            width: 300px;
            border: 1px solid #ccc;
        }

        .buttonG 
        {
          background-color: #04AA6D; /* Green */
          border: none;
          color: white;
          padding: 15px 32px;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 16px;
        }
         .buttonR 
        {
          background-color: #f44336; /* red */
          border: none;
          color: white;
          padding: 15px 32px;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 16px;
        }
          .buttonB 
        {
          background-color: #008CBA; /* Blue */
          border: none;
          color: white;
          padding: 15px 32px;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 16px;
        }
        .auto-style1 {
            color: #FF0000;
        }
        .auto-style2 {
            color: #CC3300;
        }
    </style>

       
  <center>
                              <table border="0" cellpadding="0" cellspacing="0" id="tbl" runat="server">  
                                   <tr>
                                    <td align ="left"> 
                                        <strong>
                                            <span class="auto-style1">Note : Please click to satrt button to compleet kyc, Don't forget to save video.</span>
                                    </strong>
                                    </td>       
                                </tr>
                                <tr>
                                    <td align = "center"> 
                                        <video id="videoElement" width="500" height="280" autoplay></video>
                                        
                                    </td>       
                                </tr>
                               <tr>
                                   <td align = "center">         
                                     <button id="startButton" class="buttonG">Start Video</button>
                                     <button id="stopButton" class="buttonR" disabled>Stop Video</button>
                                    <button id="saveButton" class="buttonB" disabled>Save Video</button>                                   
                                  </td>       
                             </tr>
                       </table>
                          </center>
                <center>
                    <strong>
                <asp:Label ID="lblmsg" runat="server" CssClass="auto-style2" ></asp:Label>
                    </strong>
                </center>
<script>
    const videoElement = document.getElementById('videoElement');
    const startButton = document.getElementById('startButton');
    const stopButton = document.getElementById('stopButton');
    const saveButton = document.getElementById('saveButton');

    let stream;
    let mediaRecorder;
    let chunks = [];

    startButton.addEventListener('click', () => {
        startCapture();
    });

    stopButton.addEventListener('click', () => {
        stopCapture();
    });

    saveButton.addEventListener('click', () => {
        saveVideo();
    });

    async function startCapture() {
        try {
            stream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
            videoElement.srcObject = stream;
            stopButton.disabled = false;
            startButton.disabled = true;
            saveButton.disabled = true;

            mediaRecorder = new MediaRecorder(stream);
            mediaRecorder.ondataavailable = event => {
                if (event.data.size > 0) {
                    chunks.push(event.data);
                }
            };

            mediaRecorder.onstop = () => {
                const blob = new Blob(chunks, { type: 'video/webm' });
                const videoUrl = URL.createObjectURL(blob);
                saveButton.disabled = false;
                videoElement.src = videoUrl;
            };

            mediaRecorder.start();
        } catch (err) {
            alert('Error accessing the webcam:', err);
        }
    }

    function stopCapture() {
        if (mediaRecorder && mediaRecorder.state === 'recording') {
            mediaRecorder.stop();
        }

        if (stream) {
            stream.getTracks().forEach(track => track.stop());
            videoElement.srcObject = null;
            stopButton.disabled = true;
            startButton.disabled = false;
        }
    }

    async function saveVideo() {
        if (chunks.length === 0) {
            alert('No video data to save.');
            return;
        }

        const blob = new Blob(chunks, { type: 'video/webm' });
        const formData = new FormData();
        formData.append('video', blob, 'captured_video.webm');

        const response = await fetch('videoKYC.aspx', {
            method: 'POST',
            body: formData
        });

        if (response.ok) {
            alert('Video saved please closed window.');
        } else {
            alert('Error saving the video:', response.statusText);
        }
    }
</script>
</body>
</html>

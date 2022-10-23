%% Comandos de Faxina
clc
clear all
close all

%% Lendo o video de entrada

 video_clouds = VideoReader('Clouds.mp4');
 video_chromakey = VideoReader('Chromakey.mp4');
 
 %% pegando cor referencia
 
frame = read(video_chromakey,70);
frame = rgb2lab(frame);
 
u = 731; 
v = 369; 

La = frame(v,u,1);
aa = frame(v,u,2);
ba = frame(v,u,3);

frame = read(video_chromakey,1);
 %% cria arquivo do vıdeo de saıda
 video_saida = VideoWriter('video_saida.avi');
 video_saida.FrameRate = video_chromakey.FrameRate;
 open(video_saida);

 %% Processamento
 
 read(video_chromakey,70);
 while hasFrame(video_chromakey)

%fprintf('time: %f\n', video_chromakey.CurrentTime);
frame = readFrame(video_chromakey,'native');
frame_clouds = readFrame(video_clouds,'native');
frame = rgb2lab(frame);

L = frame(:,:,1);
a = frame(:,:,2);
b = frame(:,:,3);

D = sqrt((La-L).^2 + (aa-a).^2 + (ba-b).^2);

L = 10;
M = D < L;
INV = (M-1).^2;

frame_clouds = double(frame_clouds)/255;
I2 = frame_clouds .* M;
frame = frame.*INV;
frame = lab2rgb(frame);
exit = I2+frame;
exit = uint8(exit*255);

 writeVideo(video_saida,exit);
 end
 
 %% salva
 close(video_saida);
 
 
 

 
 
 
 
 
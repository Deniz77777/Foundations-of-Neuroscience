clc
clear all
close all

load('V2');
%%
Trial_Number = input('\nEnter the number of trial:\n','s');
Name = input('\nEnter your name:\n','s');
Age = input('\nEnter your age:\n','s');

file_name = ['trial_', num2str(Trial_Number), '.txt'];

file = fopen(file_name, 'w');

fprintf(file, 'Trial number: %s\nName: %s\nAge: %s\n\n', Trial_Number, Name, Age);

PsychDefaultSetup(1);
Screen('Preference','SkipSyncTests',2);
getScreens = Screen('Screens');
chosenScreen = max(getScreens);

white=WhiteIndex(chosenScreen);
black=BlackIndex(chosenScreen);
grey = white / 2;

[w, scr_rect] = PsychImaging('OpenWindow', chosenScreen, [0 0 0], []);
[centerX, centerY] = RectCenter(scr_rect);

ifi=Screen('GetFlipInterval',w);
hertz=FrameRate(w);

IM=Screen('MakeTexture',w,V2{1});
Screen('DrawTexture',w,IM);
vbl=Screen('Flip',w);

waitframes = 1;
KeyCode(69) = 0;
KeyCode(37) = 0; % left arrow key
KeyCode(39) = 0; % right arrow key
KeyIsDown = 0;

device = serial('COM8', 'BaudRate', 57600);
fopen(device);
fwrite(device, '100');
pause(2);
fwrite(device, '1');
time_base = GetSecs;
c = clock;
fprintf(file,'Starting Time:\n Year: %4.0f - Month: %4.0f - Day: %4.0f - Hour: %4.0f - Minute: %4.0f - Second: %4.3f\n\n\n', c);
L = 1;
R = 1;
while KeyIsDown == 0
    for ii = 1 : 2151
        [KeyIsDown, secs, KeyCode] = KbCheck;
        IM = Screen('MakeTexture', w, V2{ii});
        Screen('DrawTexture', w, IM);
        vbl = Screen('Flip', w, vbl + (waitframes - 0.5) * ifi);
        
        if KeyCode(69) == 1
            Screen('CloseAll');
            break;
        end
        
        if KeyCode(37) == 1 && R == 1
            sec_l = GetSecs - time_base;
            fprintf(file,'Left  detected at time: %6.3f\n', sec_l);
            R = 0;
            L = 1;
        end
        
        if KeyCode(39) == 1 && L == 1
            sec_r = GetSecs - time_base;
            fprintf(file,'Right detected at time: %6.3f\n', sec_r);
            R = 1;
            L = 0;
        end
        
        sec_l = 0;
        sec_r = 0;
    end
end

fprintf(file,'\nEnd\n');
fclose(file);
fclose(device);
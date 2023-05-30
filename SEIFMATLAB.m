% Crearea figurii principale
fig = figure('Name', 'Seif MATLAB', 'NumberTitle', 'off', 'Position', [50, 100, 400, 500]);

% Text de titlu
title_text = uicontrol('Style', 'text', 'String', 'SEIF', 'FontSize', 16, 'HorizontalAlignment', 'center', 'Position', [50, 450, 300, 30]);

% Câmp pentru introducerea parolei
password_label = uicontrol('Style', 'text', 'String', 'Parolă:', 'FontSize', 12, 'HorizontalAlignment', 'left', 'Position', [50, 400, 80, 20]);
password_edit = uicontrol('Style', 'edit', 'String', '', 'FontSize', 12, 'Position', [120, 390, 150, 40]);

% Butoane petru numere
num_buttons = cell(1, 10);
button_width = 50;
button_height = 40;
button_spacing = 20;
row_count = 3;
column_count = 3;
start_x = 30;
start_y = 210;

for i = 1:9
    column = mod(i-1, column_count);
    row = row_count - floor((i-1) / column_count) - 1;
    x = start_x + column * (button_width + button_spacing);
    y = start_y + row * (button_height + button_spacing);
    
    num_buttons{i} = uicontrol('Style', 'pushbutton', 'String', num2str(i), 'FontSize', 12, 'Position', [x, y, button_width, button_height]);
    
    % Setarea funcției de apel pentru fiecare buton
    set(num_buttons{i}, 'Callback', {@appendNumber, password_edit});
end

% Butonul pentru cifra 0
num_buttons{10} = uicontrol('Style', 'pushbutton', 'String', '0', 'FontSize', 12, 'Position', [100,160,50,40]);
set(num_buttons{10}, 'Callback', {@appendNumber, password_edit});

% Butonul de ștergere
delete_button = uicontrol('Style', 'pushbutton', 'String', 'Șterge', 'FontSize', 12, 'Position', [250,175,80,50]);
set(delete_button, 'Callback', {@deleteNumber, password_edit});

%Butonul de resetare
reset_button = uicontrol('Style', 'pushbutton', 'String', 'Resetare', 'FontSize', 12, 'Position', [250, 250, 80, 50]);
set(reset_button, 'Callback', {@resetPassword, password_edit});

% Butonul de verificare a parolei
check_button = uicontrol('Style', 'pushbutton', 'String', 'Verifică', 'FontSize', 12, 'Position', [250, 320, 80, 50]);

% Text de rezultat (afișat dacă parola este corectă sau nu)
result_text = uicontrol('Style', 'text', 'String', '', 'FontSize', 12, 'HorizontalAlignment', 'center', 'Position', [50, 100, 200, 30]);

  % Setarea funcției de apel pentru butonul de verificare
check_button.Callback = {@verifyPassword, check_button, password_edit, result_text};

  % Definirea funcției deleteNumber
function deleteNumber(src, event, password_edit)
    current_password = get(password_edit, 'String');
    if ~isempty(current_password)
        new_password = current_password(1:end-1);
        set(password_edit, 'String', new_password);
    end 
end 
% Definirea funcției appendNumber
function appendNumber(src, event, password_edit)
    current_password = get(password_edit, 'String');
    num = get(src, 'String');
    new_password = [current_password, num];
    set(password_edit, 'String', new_password);
end


% Definirea funcției resetPassword
function resetPassword(src, event, password_edit)
    set(password_edit, 'String', '');
end


function verifyPassword(src, event, check_button,password_edit,result_text)
    correct_password = '4224'; % Parola corectă
entered_password = password_edit.String;

    if strcmp(entered_password, correct_password)
        set(result_text, 'String', 'Parola este corectă!','ForegroundColor', 'green');
    else
        set(result_text, 'String', 'Parola este incorectă!', 'ForegroundColor', 'red');
    end

end

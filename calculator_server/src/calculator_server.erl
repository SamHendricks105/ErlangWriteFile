-module(calculator_server).

-export([start/0,loop/0,rpc/2,write_to_file/1]).



start() ->
    spawn(?MODULE, loop, []).

% without rpc(Remote procedure call I need to use receive X -> X end. to get my message
rpc(Pid,Message)->
    Pid ! {self(),Message},
    receive
        Response ->
            Response
        end.

write_to_file(Message)when is_float(Message)-> write_to_file(float_to_list(Message));

write_to_file(Message) when is_integer(Message)-> write_to_file(integer_to_list(Message));

write_to_file(Message)->file:write_file("src//text.txt",Message, [append]).

convert_to_string(Number) when is_float(Number)->float_to_list(Number);

convert_to_string(Number) when is_integer(Number)-> integer_to_list(Number).


loop()->
    
    % Add
    receive
   
    {Client, {Num1, Num2, "add"} }->
        Data = Num1+Num2,
        N1 =convert_to_string(Num1),
        N2 =convert_to_string(Num2),
        write_to_file(N1++"+"++N2++"="),
        write_to_file(Data),
        write_to_file("\n"),
        Client ! Data;
       
    %  Subtract 
    
    {Client, {Num1, Num2, "sub"}}->
        Data = Num1-Num2,
        N1 =convert_to_string(Num1),
        N2 =convert_to_string(Num2),
        write_to_file(N1++"-"++N2++"="),
        write_to_file(Data),
        write_to_file("\n"),
        Client ! Data;
    
    {Client, {Num1, Num2, "subtract"}}->
        Data = Num1-Num2,
        N1 =convert_to_string(Num1),
        N2 =convert_to_string(Num2),
        write_to_file(N1++"-"++N2++"="),
        write_to_file(Data),
        write_to_file("\n"),
        Client ! Data;
    % multiply 
    {Client, {Num1, Num2, "mul"}}->
        Data = Num1*Num2,
        N1 =convert_to_string(Num1),
        N2 =convert_to_string(Num2),
        write_to_file(N1++"*"++N2++"="),
        write_to_file(Data),
        write_to_file("\n"),
        Client ! Data;
    
    {Client, {Num1, Num2, "multiply"}}->
        Data = Num1*Num2,
        N1 =convert_to_string(Num1),
        N2 =convert_to_string(Num2),
        write_to_file(N1++"*"++N2++"="),
        write_to_file(Data),
        write_to_file("\n"),
        Client ! Data;
    % divide 
    {Client, {Num1, Num2, "divide"}}->
        Data = Num1/Num2,
        N1 =convert_to_string(Num1),
        N2 =convert_to_string(Num2),
        write_to_file(N1++"/"++N2++"="),
        write_to_file(Data),
        write_to_file("\n"),
        Client ! Data;
    
    {Client, {Num1, Num2, "divi"}}->
        Data = Num1/Num2,
        N1 =convert_to_string(Num1),
        N2 =convert_to_string(Num2),
        write_to_file(N1++"/"++N2++"="),
        write_to_file(Data),
        write_to_file("\n"),
        Client ! Data;
    
    % 
    {Client, {R1, R2,Voltage, "voltage"}}->
        Data = R1/(R1+R2)*Voltage,
        write_to_file("Voltage Divider: "),
        write_to_file(Data),
        write_to_file("\n"),
        Client ! Data;

    {Client, {R1, R2,Current, "current"}}->
        Data = R2/(R2+R1)*current,
        write_to_file("Current Divider: "),
        write_to_file(Data),
        write_to_file("\n"),
        Client ! Data


    end,
    
    loop().


 



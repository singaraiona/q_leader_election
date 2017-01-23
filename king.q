nodes:(`:10.115.66.174:5001`:10.115.66.174:5002`:10.115.66.174:5003);
addrp:{`$(":","."sv string"i"$0x0 vs .z.a),":",string system "p"};
sleep:{t::"v"$.z.t;{"v"$.z.t}/[{x<t+4};t]};
// king api
id:$[(count nodes)>n:1+nodes?addrp[];n;-1];
ask:$[-1<>id;id _ nodes;()];
king:$[-1=id;1;`];
hs:{neg hopen hsym x}'[ask];
clb:{reply::x};reply:`;t:"v"$.z.t;
res:({$[-7h=type king;`IMTHEKING;`FINETHANKS]};{};{};{});
req:{(neg .z.w)(y;(((`$"ALIVE?";`$"FINETHANKS";`$"IMTHEKING";`$"PING")!(res))x)[])};
init:{x(`req;`$"ALIVE?";`clb)};
cx:{(reply<>`) or x<t+4};
wa:{reply:`;t::"v"$.z.t;{(reply<>`)or("v"$.z.t<t+4)}/[{x};t]};


init'[hs]
wa[]
T:1;
print:{0N!x;};
nodes:(`::5001`::5002`::5003);
lap:{(":","."sv string"i"$0x0 vs .z.a),":",string system "p"};
addrp:{`$"::",string system "p"};
sleep:{t::"v"$.z.t;{"v"$.z.t}/[{x<t+T*4};t]};
reply:`;t:"v"$.z.t;seq:0;
// king api
id:$[(count nodes)>n:1+nodes?addrp[];n;-1];
print string id;
parents:$[-1<>id;id _ nodes;()];
king:$[-1=id;1;`];
hs:{neg hopen hsym x}'[parents];
clb:{reply::x;print (string x),(string y),lap[]};
res:({$[-7h=type king;`IMTHEKING;`FINETHANKS]};{};{};{});
req:{(neg .z.w)(z;(((`$"ALIVE?";`$"FINETHANKS";`$"IMTHEKING";`$"PING")!(res))x)[];y)};
ask:{x(`req;`$"ALIVE?";seq;`clb)};

cx:{(reply<>`) or x<t+4};

wc:{reply:`;t::"v"$.z.t;{(reply<>`)or("v"$.z.t<t+4)}/[{x};t]};






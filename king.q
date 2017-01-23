// timeout
T:1;
// debug function
print:{0N!x;};
// all nodes in ring
nodes:(`::5001`::5002`::5003);
// get local address:port
lap:{(":","."sv string"i"$0x0 vs .z.a),":",string system "p"};
// the same except address
addrp:{`$"::",string system "p"};
// initials
reply:`;t:"v"$.z.t;seq:0;
// king api
id:$[(count nodes)>n:1+nodes?addrp[];n;-1];
// just info about starting instance.
print string id;
// get all parents should be alive?
parents:$[-1<>id;id _ nodes;()];
// are we king?
king:$[-1=id;1;`];
// opened handles of async connections
hs:{neg hopen hsym x}'[parents];
// callback function: called from other side of connection via async request `req
clb:{reply::x;print (string x)," seq:",(string y),lap[]};
// parse requested function from api
res:({$[-7h=type king;`IMTHEKING;`FINETHANKS]};{};{};{`PONG});
// async request
req:{(neg .z.w)(z;(((`$"ALIVE?";`$"FINETHANKS";`$"IMTHEKING";`$"PING")!(res))x)[];y)};
// condition: received reply or timeout is reached
cx:{(reply<>`)or("v"$.z.t<t+T*4)};
// wait until condition cx reaches
wc:{reply:`;t::"v"$.z.t;{cx[]}/[{x};t]};
// api request
ask:{x(`req;y;seq;`clb)};
// alive?
chk:{ask[x;`$"ALIVE?"]};
// ping
ping:{ask[x;`PING]};





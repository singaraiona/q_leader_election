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
// are we the king?
king:$[-1=id;0;`];
weking:{-7h=type king};
// callback function: called from other side of connection via async request `req
clb:{reply::x;print (string x)," seq:",(string y),z};
// parse requested function from api
res:({$[weking[];`IMTHEKING;`FINETHANKS]};{};{};{`PONG});
// async request
req:{(neg .z.w)(z;(((`$"ALIVE?";`$"FINETHANKS";`$"IMTHEKING";`$"PING")!(res))x)[];y;lap[])};
// condition: received reply or timeout is reached
cx:{(reply<>`)or("v"$.z.t)>t+T*4};
// wait until condition cx reaches
wc:{reply::`;t::"v"$.z.t;{cx[]}/[{x};t]};
// api request
ask:{(neg hopen hsym x)(`req;y;seq;`clb)};
// alive?
chk:{ask[x;`$"ALIVE?"]};
// ping
ping:{ask[x;`PING]};
// start pinging
{chk x; wc[]}'[parents];
// set proper king handle
king:$[weking[];0;last parents];
// debug
print "king: ",string king
// monitor participants 
hdl:{(`$"ALIVE?";`$"FINETHANKS";`$"IMTHEKING";`$"PING")!({};{};{};{})};
tick:{if[not weking[];ping king];wc[];hdl reply;};
// setup timer
.z.ts: {tick[]};
system "t ", string 4000*T;




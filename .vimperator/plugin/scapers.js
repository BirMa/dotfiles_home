    
var increment2 = function(count) {
  let matches = buffer.URL.match(/(.*?)(\d+)(\D+)(\d+)(\D*)$/);
  liberator.assert(matches);

  let [, pre, num1, noNum1, num2, post] = matches;
  let num1_inc = parseInt(num1, 10) + count;
  let num1_inc_str = String(num1_inc > 0 ? num1_inc : 0);
  if(num1.match(/^0/)) {
    while(num1_inc_str.length < num1.lenth)
      num1_inc_str = "0" + num1_inc_str;
  }

  liberator.open(pre + num1_inc_str + noNum1 + num2 + post);
}

var increment3 = function(count) {
  let matches = buffer.URL.match(/(.*?)(\d+)(\D+)(\d+)(\D+)(\d+)(\D*)$/);
  liberator.assert(matches);

  let [, pre, num1, noNum1, num2, noNum2, num3, post] = matches;
  let num1_inc = parseInt(num1, 10) + count;
  let num1_inc_str = String(num1_inc > 0 ? num1_inc : 0);
  if(num1.match(/^0/)) {
    while(num1_inc_str.length < num1.lenth)
      num1_inc_str = "0" + num1_inc_str;
  }

  liberator.open(pre + num1_inc_str + noNum1 + num2 + noNum2 + num3 + post);
}

var increment4 = function(count) {
  let matches = buffer.URL.match(/(.*?)(\d+)(\D+)(\d+)(\D+)(\d+)(\D+)(\d+)(\D*)$/);
  liberator.assert(matches);

  let [, pre, num1, noNum1, num2, noNum2, num3, noNum3, num4, post] = matches;
  let num1_inc = parseInt(num1, 10) + count;
  let num1_inc_str = String(num1_inc > 0 ? num1_inc : 0);
  if(num1.match(/^0/)) {
    while(num1_inc_str.length < num1.lenth)
      num1_inc_str = "0" + num1_inc_str;
  }

  liberator.open(pre + num1_inc_str + noNum1 + num2 + noNum2 + num3 + noNum3 + num4 + post);
}

commands.addUserCommand(['inc2'],
    "increment 2nd number of uri",
    function(args) {
      if(args.length > 0)
        increment2(args[0]);
      else
        increment2(1);
    });

commands.addUserCommand(['dec2'],
    "decrement 2nd number of uri",
    function(args) {
      if(args.length > 0)
        increment2(-args[0]);
      else
        increment2(-1);
    });

commands.addUserCommand(['inc3'],
    "increment 3rd number of uri",
    function(args) {
      if(args.length > 0)
        increment3(args[0]);
      else
        increment3(1);
    });

commands.addUserCommand(['dec3'],
    "decrement 3rd number of uri",
    function(args) {
      if(args.length > 0)
        increment3(-args[0]);
      else
        increment3(-1);
    });

commands.addUserCommand(['inc4'],
    "increment 4rd number of uri",
    function(args) {
      if(args.length > 0)
        increment4(args[0]);
      else
        increment4(1);
    });

commands.addUserCommand(['dec4'],
    "decrement 4rd number of uri",
    function(args) {
      if(args.length > 0)
        increment4(-args[0]);
      else
        increment4(-1);
    });

commands.addUserCommand(['ue'],
    "unescape uri",
    function(args) {
        if(args.length != 0)
            for(i = 0; i < args.length; i++)
                liberator.open(unescape(args[i]), liberator.NEW_BACKGROUND_TAB);
        else
            liberator.echoerr("no uri");
    });

commands.addUserCommand(['ae'],
    "unescape obscured uri",
    function(args) {
        if(args.length != 0)
            for(i = 0; i < args.length; i++)
                liberator.open("http".concat( unescape(args[i]).split(/http/).pop() ).split(/&/)[0], liberator.NEW_BACKGROUND_TAB);
        else
            liberator.echoerr("no uri");
    });
        
commands.addUserCommand(['Ae'],
    "unescape obscured uri",
    function(args) {
        if(args.length != 0)
            for(i = 0; i < args.length; i++)
                liberator.open("http".concat( unescape(args[i]).split(/http/).pop() ).split(/&/)[0], liberator.NEW_BACKGROUND_TAB);
        else
            liberator.echoerr("no uri");
    });
        

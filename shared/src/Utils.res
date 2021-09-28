@val
external arguments: array<'a> = "arguments"

module Timer = {
  type intervalId
  type timeoutId

  @val
  external setInterval: (@uncurry (unit => unit), int) => intervalId = "setInterval"

  @val
  external setTimeout: (@uncurry (unit => unit), int) => timeoutId = "setTimeout"

  @val
  external clearInterval: intervalId => unit = "clearInterval"

  @val
  external clearTimeout: timeoutId => unit = "clearTimeout"
}

let rest: (array<'a> => 'b) => Js.Fn.arity0<'b> = f => {
  (. ()) => {
    let args: array<'a> = arguments
    f(args)
  }
}

let rest2: (('a, array<'b>) => 'c) => Js.Fn.arity0<'c> = f => {
  (. ()) => {
    let args = arguments
    let arg0: 'a = args[0]
    let rest: array<'b> = args->Belt.Array.slice(~offset=1, ~len=args->Js.Array2.length)
    f(arg0, rest)
  }
}

let resultToOption: result<'a, 'b> => option<'a> = res => {
  switch res {
  | Ok(res) => Some(res)
  | Error(err) => {
      Js.log(err)
      None
    }
  }
}

@val @scope("Object") @variadic
external assign: array<{..}> => {..} = "assign"

let mergeObjects: array<{..}> => {..} = objects =>
  assign(Js.Array2.concat([Js.Obj.empty()], objects))

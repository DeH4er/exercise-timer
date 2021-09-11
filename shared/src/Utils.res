@val
external arguments: array<'a> = "arguments"

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
let set: ('a, string, 'a => string) => Promise.t<result<unit, Node.Fs.err>>
let get: (string, string => option<'a>) => Promise.t<result<'a, Node.Fs.err>>

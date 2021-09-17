let set: ('a, string) => Promise.t<result<unit, Node.Fs.err>>
let get: string => Promise.t<result<'a, Node.Fs.err>>

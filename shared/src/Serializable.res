module type Serializable = {
  type t
  let default: Jzon.codec<t>
}

module MakeSerializable = (Item: Serializable) => {
  let toString: Item.t => string = item => item->Jzon.encodeStringWith(Item.default)
  let fromString: string => option<Item.t> = itemStr =>
    itemStr->Jzon.decodeStringWith(Item.default)->Utils.resultToOption
}

module MakePropsUtils = (
  Item: {
    type t
  },
) => {
  type t = Item.t

  external propsToObj: Item.t => {..} = "%identity"
  external objToProps: {..} => Item.t = "%identity"

  external propsArrToObj: array<Item.t> => array<{..}> = "%identity"
  external objArrToProps: array<{..}> => array<Item.t> = "%identity"

  let merge: array<Item.t> => Item.t = props => {
    props->propsArrToObj->Shared.Utils.mergeObjects->objToProps
  }
}

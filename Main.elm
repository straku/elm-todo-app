import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.App as Html

main =
  Html.beginnerProgram
  { model = model,
    update = update,
    view = view
  }

-- model
type alias Model =
  { todo: String,
    todos: List String
  }

model =
  { todo = "",
    todos = []
  }

-- update
type Msg
  = UpdateText String
  | AddItem
  | RemoveItem String

update msg model =
  case msg of
    UpdateText text ->
      { model | todo = text }
    AddItem ->
      { model | todos = model.todo :: model.todos }
    RemoveItem text ->
      { model | todos = List.filter (\todo -> todo /= text) model.todos }

-- view
todoItem todo =
  li [] [text todo,
         button [onClick (RemoveItem todo)] [text "X"]]

todoList todos =
  let
    children = List.map todoItem todos
  in
    ul [] children


view model =
  div [] [
    input [type' "text",
           onInput UpdateText,
           value model.todo] [],
    button [onClick AddItem] [text "Add Todo"],
    div [] [text model.todo],
    todoList model.todos
  ]

import json


def get_output_path(f_path: str, input_path: str, output_path: str) -> str:
    return f_path.replace(".json", ".gv").replace(input_path, output_path)


def board_to_str(node: dict) -> str:
    board = [
        s.strip() for s in node["board"].replace("[", "").replace("]", "").split(",")
    ]
    boards = []
    for i in range(0, len(board), 3):
        el = board[i : i + 3]
        boards.append(" | ".join([e if e else " " for e in el]))
    board_str = "\n".join(boards)
    return f"{'Max' if node['isMaxNode'] else 'Min'} node ({'O' if node['isMaxNode'] else 'X'})\nDepth: {node['depth']}, Value: {node['value']}\n\n{board_str}"


def generate_tuples(states: list[dict]) -> dict[int, list[int]]:
    parent_children = {}
    stack = []

    for i, state in enumerate(states):
        depth = state["depth"]
        parent_children[i] = []

        while stack and stack[-1][0] >= depth:
            stack.pop()

        if stack:
            parent_index = stack[-1][1]
            parent_children[parent_index].append(i)

        stack.append((depth, i))

    return parent_children


def load_json(f) -> dict:
    if type(f) == str:
        with open(f, "r") as f:
            states: dict = json.load(f)
    else:
        states: dict = json.load(f)
    return states

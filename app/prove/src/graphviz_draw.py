from os.path import join
from os import listdir

from utils.graphviz_write import write_tree
from utils.json_parser import load_json, get_output_path

input_path: str = join("..", "input")
output_path: str = join("..", "output")
folders_path: list[str] = [
    join(input_path, "match_30_4_2024_3_54_15")
]  # [join(input_path, f) for f in listdir(input_path)]
files_path: list[str] = [
    join(folder, f)
    for folder in folders_path
    for f in listdir(folder)
    if f.endswith(".json")
]

print(files_path)


def draw_w_graphviz(input_path: str, output_path: str, files_path: list[str]) -> None:
    for f_path in files_path:
        file_path = get_output_path(f_path, input_path, output_path)
        print(file_path)
        with open(f_path, "r") as f:
            states: dict = load_json(f)
            write_tree(file_path, states)


if __name__ == "__main__":
    draw_w_graphviz(input_path, output_path, files_path)

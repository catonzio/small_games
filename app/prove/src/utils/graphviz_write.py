import graphviz
from utils.json_parser import board_to_str, generate_tuples


def write_tree_old(output_path: str, states: list[dict]) -> None:
    dot = graphviz.Digraph(comment="The tree")

    for i, state in enumerate(states):
        dot.node(str(i), board_to_str(state))

    tuples: dict[int, list[int]] = generate_tuples(states)

    for parent_idx, children_idxs in tuples.items():
        for c_idx in children_idxs:
            if c_idx:
                dot.edge(str(parent_idx), str(c_idx))

    dot.render(output_path, view=True).replace("\\", "/")


def write_tree(output_path: str, states: dict) -> None:
    colors = [
        "red",
        "blue",
        "green",
        "purple",
        "orange",
        "pink",
        "brown",
        "black",
        "gray",
    ]
    dot = graphviz.Digraph(comment="The tree", strict=True)

    for state in states.values():
        color = colors[0] if state["value"] < 0 else colors[2]
        # color = "green" if child["value"] == state["value"] else "black"
        dot.node(
            name=str(state["id"]),
            label=board_to_str(state),
            color=color,
            shape="box" if state["isMaxNode"] else "ellipse",
        )

        for child in state["children"]:
            color = (
                "green" if states[f'{child}']["value"] == state["value"] else "black"
            )
            dot.edge(str(state["id"]), str(child), color=color)
    # tuples: dict[int, list[int]] = generate_tuples(states)

    # for parent_idx, children_idxs in tuples.items():
    #     for c_idx in children_idxs:
    #         if c_idx:
    #             dot.edge(str(parent_idx), str(c_idx))

    dot.render(output_path, view=True).replace("\\", "/")

from flask import Flask, request
import emoji
from flask import render_template


app = Flask(__name__)


@app.route('/', methods=['GET'])
def car_game():
    return render_template("cargame.html")


@app.route('/', methods=['POST'])
def animals():
    data = request.get_json(force=True)
    input_animal = data['animal']
    ready_animal = emoji.emojize(':' + input_animal + ':')
    sound_animal = data['sound']
    count = int(data['count'])
    signature = emoji.emojize(':heart:', use_aliases=True)
    return ((ready_animal + " says " + sound_animal + "\n") * count) + "Made with " + signature + " by Xarakiri" + "\n"


if __name__ == '__main__':
    app.run(host='0.0.0.0')


#Paso 1

#Crear una página con solo HTML
#Agregar una imagen en la parte superior 
#Agregar un Tag H1 con su nombre y editar el color
#Agregar un párrafo con su breve descripción, editando color y borde

import dash
from dash import html

app = dash.Dash(__name__)

app.layout = html.Div(children=[

    html.Img(
        src='assets/800px-GreenMountainWindFarm_Fluvanna_2004.jpg',
        style={'width': '30%', 'border': '1px solid black'},
        alt='image'),

    html.H1(children='Jose Beltran', style={'color': 'green'}),
    html.H1(children='DEACERO', style={'color': 'green'}),
    html.P('Coordinacion de eficiencia energetica', style={'color': 'black', 'border': '2px solid black'})
])

if __name__ == '__main__':
    app.run_server(debug=True)
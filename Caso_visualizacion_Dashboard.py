#Parte 13

#Crear un dashboard interactivo con Plotly Dash

import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output
import plotly.express as px
import pandas as pd
import numpy as np

df = pd.read_csv('C:/Users/JBELTRAN/Documents/Data_translator/Caso Visualizacion/df.csv')
app = dash.Dash(__name__)

#Agregar un tag H! con el título del dashopard

app.layout = html.Div(children=[
    html.H1(children='Dashboard - Caso de visualizacion', style={'color': 'black', 'backgroundColor': 'white'}),

#Agregar una imagen acorde al dashboard
    html.Img(
        src='https://economipedia.com/wp-content/uploads/2017/07/estadistica.jpg',
        style={'width': '50%', 'border': '15px solid black'}),

#Agregar un menú desplegable y un gráfico de puntos

    dcc.Dropdown(
    id="dropdown",

#El menú desplegable debe contener un listado de categorías únicas en orden alfabético generado a partir de los datos
    
    options=[{"label": x, "value": x} for x in np.sort(df['category_title'].unique())],
    value='Gaming'
    ),
    dcc.Graph(id='graph-dropdown'),
])

@app.callback(
    Output('graph-dropdown', 'figure'),
    Input('dropdown', 'value'))

def update_figure(dims):
    filtered_df = df[df['category_title'] == dims]
    
#Al seleccionar un valor en el menú desplegable la gráfica de puntos deberá mostrar los “Likes” vs “Dislikes” de la categoría seleccionada

#La gráfica de puntos debe incluir una línea de best fit

    figura = px.scatter(filtered_df,x='likes',y='dislikes',title='Likes vs Dislikes',trendline='ols')
    return figura

if __name__ == '__main__':
    app.run_server(debug=True)
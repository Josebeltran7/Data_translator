#Paso 3

#Utilizando el archivo “auto-mpg.csv”
#Cargar el archivo en el código del dashboard
#Agregar un tag H1 con el texto “Desplazamiento vs Peso”
#Agregar la imagen de un automóvil
#Crear un gráfico de puntos donde el eje X sea “Displacement” y el eje Y sea “Weight” que incluya una línea de best fit utilizando OLS

import dash
from dash import dcc
from dash import html
from dash.dependencies import Input, Output
import plotly.express as px

import pandas as pd

df = pd.read_csv('C:/Users/JBELTRAN/Documents/Data_translator/Visualizacion/datasets/auto-mpg.csv')

app = dash.Dash(__name__)

fig = px.scatter(df, x="displ", y="weight",
                    log_x=True, size_max=55, trendline="ols")

app.layout = html.Div(children=[
    html.H1("Desplazamiento vs Peso"),
    html.Img(
        src='https://www.mundodelmotor.net/wp-content/uploads/2017/07/historia-del-automovil-1.jpg',
        style = {'width': '80%'}),
    dcc.Graph(
        figure=fig
    )
])
    

if __name__ == '__main__':
    app.run_server(debug=True)
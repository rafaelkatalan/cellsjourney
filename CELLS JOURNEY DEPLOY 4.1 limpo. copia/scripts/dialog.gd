extends Control

# array onde contém o texto pois queremos várias partes de diálogo
var dialog = [
	"A prática de exercícios aeróbicos pode reduzir o risco de desenvolvimento de vários tipos de câncer. Vale pular corda, dançar, andar de bicicleta, nadar e principalmente correr. ",
	"Agora que você tem este tênis, você pode usá-lo para correr mais rápido ou realizar um salto duplo. Esta nova habilidade vai ser muito útil para você em breve.",
	"Para correr, pressione a tecla 'Shift' + a seta da direção desejada. Para realizar dois saltos, pressione a seta para cima duas vezes."
]

var dialog_index = 0 # para separar em diferentes diálogos "atuais"
var finished = false # para saber se acabaram ou não os diálogos

func _ready():
	hide()
	load_dialog() #carrega o diálogo
	
func _process(_delta):
#	aparece quando pega o tenis
	if ScriptGlobal.tenis == 2:
		show()
	$"setinha".visible = finished

	if Input.is_action_just_pressed("ui_accept"): 
		$somClick.play()
		load_dialog() #se for pressionado, carrega o próximo diálogo
	
func load_dialog(): # função de carregar dialogo
	if dialog_index < dialog.size(): # tem que ser menor para não passar a qtd desejada
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index] #puxa o nó de richtext.bbcode e iguala ao índice do diálogo
		$RichTextLabel.percent_visible = 0 # percentual visível do texto(vai de 0 a 1), para o texto ir andando aos poucos
		$Tween.interpolate_property( # vai interpolar o percentual visível do texto de forma linear de 0 a 1 em 1 segundo
			$RichTextLabel, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		#print("roger lindo")
	else:
		queue_free()# se for maior que o tamanho, remove tudo
		
	dialog_index += 1 #soma um para cada diálogo carregado

func _on_Tween_tween_completed(_object, _key):
	finished = true



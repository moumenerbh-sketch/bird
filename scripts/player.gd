extends CharacterBody2D

# الثوابت: يمكنك تعديلها من واجهة Inspector لتجربة قيم مختلفة
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# الحصول على قيمة الجاذبية من إعدادات المشروع الافتراضية
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# 1. إضافة الجاذبية إذا لم يكن اللاعب على الأرض
	if not is_on_floor():
		velocity.y += gravity * delta

	# 2. التعامل مع القفز
	# تأكد من إضافة "jump" في الـ Input Map واختيار زر المسطرة (Space)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. الحصول على اتجاه الحركة (يمين/يسار)
	# تأكد من إضافة "left" و "right" في الـ Input Map
	var direction := Input.get_axis("left", "right")
	
	if direction != 0:
		# إذا كان هناك إدخال، تحرك بالسرعة المحددة
		velocity.x = direction * SPEED
	else:
		# إذا لم يضغط اللاعب شيئاً، توقف تدريجياً (تبني التباطؤ)
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. تفعيل الحركة والتصادم
	move_and_slide()

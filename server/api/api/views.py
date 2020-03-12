from django.shortcuts import render
from django.http import HttpResponse, HttpResponseForbidden, HttpResponseNotFound, JsonResponse

# Create your views here.
def robots_txt(request):
    return HttpResponse("User-Agent: *\nDisallow: /", content_type="text/plain")

# GAMMA API
def echo_api(request, user_txt):
    # docs: https://docs.djangoproject.com/en/3.0/ref/request-response/
    return JsonResponse({'user_input': user_txt, 'request': request.method, 'server': request.META.get("SERVER_NAME"), 'ip': request.META.get("REMOTE_ADDR")})

def training_api(request):
    # TODO: Training API
    if request.method == 'POST':
        return JsonResponse({'result': 'Ok'})
    else:
        return JsonResponse({'result': 'Bad Request'})
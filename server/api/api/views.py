from django.shortcuts import render
from django.http import HttpResponse, HttpResponseForbidden, HttpResponseNotFound, JsonResponse

# Create your views here.
def robots_txt(request):
    return HttpResponse("User-Agent: *\nDisallow: /", content_type="text/plain")

# GAMMA API
def echo_api(request, user_txt):
    return JsonResponse({'user_input': user_txt, 'request': request.method})